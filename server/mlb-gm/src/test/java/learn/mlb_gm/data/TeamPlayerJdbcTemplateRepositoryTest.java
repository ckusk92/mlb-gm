package learn.mlb_gm.data;

import learn.mlb_gm.models.TeamPlayer;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.NONE)
public class TeamPlayerJdbcTemplateRepositoryTest {

    final static int NEXT_TEAM_PLAYER_ID = 11;

    @Autowired
    TeamPlayerJdbcTemplateRepository repository;

    @Autowired
    KnownGoodState knownGoodState;

    @BeforeEach
    void setup() {knownGoodState.set();}

    @Test
    void shouldFindAllTen() {
        List<TeamPlayer> all = repository.findAll();
        assertEquals(10, all.size());
    }

    @Test
    void shouldFindAllFiveForTeamOne() {
        List<TeamPlayer> all = repository.findAllForTeam(1);
        assertEquals(5, all.size());
    }

    @Test
    void shouldFindTeamPlayerTwo() {
        TeamPlayer mitch = repository.findById(2);
        assertEquals(2, mitch.getTeamPlayerId());
    }

    @Test
    void shouldAdd() {
        TeamPlayer teamPlayer = new TeamPlayer(1, 8);
        TeamPlayer actual = repository.add(teamPlayer);
        assertNotNull(actual);
        assertEquals(NEXT_TEAM_PLAYER_ID, actual.getTeamPlayerId());
        assertEquals(1, actual.getUserTeamId());
    }

    @Test
    void shouldUpdate() {
        TeamPlayer teamPlayer = new TeamPlayer(1, 1, 11);
        assertTrue(repository.update(teamPlayer));
        assertEquals(11, repository.findById(1).getPlayerId());
    }

    @Test
    void shouldNotUpdateMissing() {
        TeamPlayer teamPlayer = new TeamPlayer(10000, 1, 11);
        assertFalse(repository.update(teamPlayer));
    }

    @Test
    void shouldDelete() {
        int before = repository.findAll().size();
        assertTrue(repository.deleteById(1));
        int after = repository.findAll().size();
        assertEquals(before - 1, after);
    }

    @Test
    void shouldNotDeleteMissing() {
        int before = repository.findAll().size();
        assertFalse(repository.deleteById(1000));
        int after = repository.findAll().size();
        assertEquals(before, after);
    }

}