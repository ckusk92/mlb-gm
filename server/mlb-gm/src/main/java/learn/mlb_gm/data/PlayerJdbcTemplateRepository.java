package learn.mlb_gm.data;

import learn.mlb_gm.data.mappers.PlayerMapper;
import learn.mlb_gm.models.Player;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@Repository
public class PlayerJdbcTemplateRepository implements PlayerRepository {

    private final JdbcTemplate jdbcTemplate;

    public PlayerJdbcTemplateRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

//    @Override
//    public List<Player> findAll() {
//        final String sql = "select player_id, first_name, last_name, position_id, rating from player";
//        return jdbcTemplate.query(sql, new PlayerMapper());
//    }

    // Changed ordering of player listing
    @Override
    public List<Player> findAll() {
        final String sql = "select player_id, first_name, last_name, position_id, rating from player order by position_id asc, rating desc";
        return jdbcTemplate.query(sql, new PlayerMapper());
    }

    @Override
    public List<Player> findAllActive(int userId) {
        final String sql = "select p.player_id, p.first_name, p.last_name, p.position_id, p.rating from player p " +
                "inner join team_player tp on p.player_id = tp.player_id " +
                "inner join user_team ut on tp.user_team_id = ut.user_team_id " +
                "where ut.app_user_id = ?";
        return jdbcTemplate.query(sql, new PlayerMapper(), userId);
    }

    @Override
    public List<Player> findFreeAgents(int userId) {

        List<Player> all = findAll();
        List<Player> active = findAllActive(userId);
        List<Player> freeAgents = new ArrayList<>();

        for(Player player : all) {
            boolean contains = false;
            for(Player actPl : active){
                if(actPl.getPlayerId() == player.getPlayerId()) {
                    contains = true;
                }
            }
            if(!contains) {
                freeAgents.add(player);
            }
        }

        return freeAgents;
    }

    @Override
    public Player findById(int playerId) {
        final String sql = "select player_id, first_name, last_name, position_id, rating from player where player_id = ?";
        return jdbcTemplate.query(sql, new PlayerMapper(), playerId).stream().findFirst().orElse(null);
    }

    @Override
    public Player add(Player player) {
        final String sql = "insert into player (first_name, last_name, position_id, rating) values(?,?,?,?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();
        int rowsAffected = jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, player.getFirstName());
            ps.setString(2, player.getLastName());
            ps.setInt(3, player.getPosition().getValue());
            ps.setInt(4, player.getRating());
            return ps;
        }, keyHolder);
        if(rowsAffected <= 0) {
            return null;
        }
        player.setPlayerId(keyHolder.getKey().intValue());
        return player;
    }

    @Override
    public boolean update(Player player) {
        final String sql = "update player set first_name = ?, last_name = ?, position_id = ?, rating = ? where player_id = ?";
        return jdbcTemplate.update(sql, player.getFirstName(), player.getLastName(),
                player.getPosition().getValue(), player.getRating(), player.getPlayerId()) > 0;
    }

    @Override
    public boolean deleteById(int playerId) {
        return jdbcTemplate.update("delete from player where player_id = ?", playerId) > 0;
    }
}
