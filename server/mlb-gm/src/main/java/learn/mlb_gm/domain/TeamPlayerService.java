package learn.mlb_gm.domain;

import learn.mlb_gm.data.PlayerRepository;
import learn.mlb_gm.data.TeamPlayerRepository;
import learn.mlb_gm.data.TeamRepository;
import learn.mlb_gm.data.UserTeamRepository;
import learn.mlb_gm.models.Player;
import learn.mlb_gm.models.Position;
import learn.mlb_gm.models.TeamPlayer;
import learn.mlb_gm.models.UserTeam;
import learn.mlb_gm.models.response_objects.TeamPlayerInfo;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

@Service
public class TeamPlayerService {

    private final TeamPlayerRepository repository;
    private final PlayerRepository playerRepository;
    private final UserTeamRepository userTeamRepository;
    private final TeamRepository teamRepository;

    public TeamPlayerService(TeamPlayerRepository repository, PlayerRepository playerRepository, UserTeamRepository userTeamRepository, TeamRepository teamRepository) {
        this.repository = repository;
        this.playerRepository = playerRepository;
        this.userTeamRepository = userTeamRepository;
        this.teamRepository = teamRepository;
    }

    public List<TeamPlayer> findAll() {return repository.findAll();}

    public List<TeamPlayer> findAllByTeam(int userTeamId) {return repository.findAllForTeam(userTeamId);}

    public List<Player> getRoster(int userId) {

        List<UserTeam> userTeams = userTeamRepository.findAllByUser(userId);

        int userTeamId = 0;
        for(UserTeam userTeam: userTeams) {
            if(userTeam.isUserControlled()) {
                userTeamId = userTeam.getUserTeamId();
            }
        }

        List<TeamPlayer> teamPlayers = repository.findAllForTeam(userTeamId);
        List<Player> players = new ArrayList<>();
        for(TeamPlayer teamPlayer : teamPlayers) {
            Player player = playerRepository.findById(teamPlayer.getPlayerId());
            player.setRating(teamPlayer.getRating());
            players.add(player);
        }
        return players;
    }

    public TeamPlayer findById(int teamPlayerId) {return repository.findById(teamPlayerId);}

    public Result<TeamPlayer> add(TeamPlayer teamPlayer) {
        Result<TeamPlayer> result = validate(teamPlayer);

        if(!result.isSuccess()) {
            return result;
        }

        if(teamPlayer.getTeamPlayerId() != 0) {
            result.addMessage("teamPlayerId cannot be set for `add` operation", ResultType.INVALID);
            return result;
        }

        teamPlayer = repository.add(teamPlayer);
        result.setPayload(teamPlayer);
        return result;
    }

    public List<TeamPlayerInfo> draft(TeamPlayer teamPlayer, int userId) {
        Random random = new Random();

        List<UserTeam> userTeams = userTeamRepository.findAllByUser(userId);
        for(UserTeam userTeam: userTeams) {
            if(userTeam.isUserControlled()) {
                teamPlayer.setUserTeamId(userTeam.getUserTeamId());
            }
        }

        List<TeamPlayerInfo> draftedPlayers = new ArrayList<>();

        Result<TeamPlayer> result = validate(teamPlayer);

//        if(teamPlayer.getTeamPlayerId() == 0) {
//            result.addMessage("Must select player", ResultType.INVALID);
//            return result;
//        }

        if(!result.isSuccess()) {
            return null;
        }

        // Add user selected player to users team if passes validation
        teamPlayer = repository.add(teamPlayer);

        TeamPlayerInfo teamPlayerInfo = new TeamPlayerInfo();
        teamPlayerInfo.setTeamName(teamRepository.findById(userTeamRepository.findById(teamPlayer.getUserTeamId()).getTeamId()).getName());
        teamPlayerInfo.setFirstName(playerRepository.findById(teamPlayer.getPlayerId()).getFirstName());
        teamPlayerInfo.setLastName(playerRepository.findById(teamPlayer.getPlayerId()).getLastName());
        teamPlayerInfo.setPosition(playerRepository.findById(teamPlayer.getPlayerId()).getPosition());
        teamPlayerInfo.setRating(playerRepository.findById(teamPlayer.getPlayerId()).getRating());
        draftedPlayers.add(teamPlayerInfo);

        //CPU teams to draft players
        List<UserTeam> teams = userTeamRepository.findAllByUser(userId);

        for(UserTeam team : teams) {
            if(!team.isUserControlled()) {
                // Refresh list every time
                List<Player> freeAgents = playerRepository.findFreeAgents(userId);

                Result<TeamPlayer> draftResult = new Result<>();
                draftResult.setType(ResultType.INVALID);

                boolean validPick = false;
                boolean positionFree = true;
                while(!validPick) {
                    int i = random.nextInt(freeAgents.size());
                    for(Player onRoster : repository.findAllPlayersForTeam(team.getUserTeamId())) {
                        positionFree = true;
                        if (freeAgents.get(i).getPosition() == onRoster.getPosition()) {
                            positionFree = false;
                        }
                    }
                    if(positionFree) {
//                        draftResult = add(new TeamPlayer(team.getUserTeamId(), freeAgents.get(i).getPlayerId()));
//                        teamPlayer = draftResult.getPayload();
                        teamPlayer = repository.add(new TeamPlayer(team.getUserTeamId(), freeAgents.get(i).getPlayerId()));
                        teamPlayerInfo = new TeamPlayerInfo();
                        teamPlayerInfo.setTeamName(teamRepository.findById(userTeamRepository.findById(teamPlayer.getUserTeamId()).getTeamId()).getName());
                        teamPlayerInfo.setFirstName(playerRepository.findById(teamPlayer.getPlayerId()).getFirstName());
                        teamPlayerInfo.setLastName(playerRepository.findById(teamPlayer.getPlayerId()).getLastName());
                        teamPlayerInfo.setPosition(playerRepository.findById(teamPlayer.getPlayerId()).getPosition());
                        teamPlayerInfo.setRating(playerRepository.findById(teamPlayer.getPlayerId()).getRating());
                        draftedPlayers.add(teamPlayerInfo);
//                        if (draftResult.isSuccess()) {
//                            validPick = true;
//                        }
                        if(teamPlayer != null) {
                            validPick = true;
                        }
                    }
                }
            }
        }
        return draftedPlayers;
    }

    public void sign(TeamPlayer teamPlayer, int userId) {

        int userTeamId = 0;
        List<UserTeam> userTeams = userTeamRepository.findAllByUser(userId);
        for(UserTeam userTeam: userTeams) {
            if(userTeam.isUserControlled()) {
                userTeamId = userTeam.getUserTeamId();
            }
        }

        Position faPosition = playerRepository.findById(teamPlayer.getPlayerId()).getPosition();
        List<Player> roster = getRoster(userId);
        // NEEDS USERTEAMID
        List<TeamPlayer> teamRoster = findAllByTeam(userTeamId);

        for(Player player : roster) {
            if(player.getPosition() == faPosition) {
                // Return to free agent list
                for(TeamPlayer tp : teamRoster) {
                    if(tp.getPlayerId() == player.getPlayerId()) {
                        System.out.println(teamPlayer.getTeamPlayerId());
                        System.out.println(repository.deleteById(tp.getTeamPlayerId()));
                    }
                }
            }
        }

        // Not sure if rating will be accurate...
        TeamPlayer newPlayer = new TeamPlayer(userTeamId, teamPlayer.getPlayerId(), teamPlayer.getRating());
        repository.add(newPlayer);
    }

    public Result<TeamPlayer> update(TeamPlayer teamPlayer) {
        Result<TeamPlayer> result = validate(teamPlayer);

        if(!result.isSuccess()) {
            return result;
        }

        if(teamPlayer.getTeamPlayerId() <= 0) {
            result.addMessage("teamPlayerId must be set for `update` operation", ResultType.INVALID);
            return result;
        }

        if(!repository.update(teamPlayer)) {
            String msg = String.format("teamPlayerId: %s, not found", teamPlayer.getTeamPlayerId());
            result.addMessage(msg, ResultType.NOT_FOUND);
        }

        return result;
    }

    public boolean deleteById(int teamPlayerId) {return repository.deleteById(teamPlayerId);}

    private Result<TeamPlayer> validate(TeamPlayer teamPlayer) {
        Result<TeamPlayer> result = new Result<>();

//        if(teamPlayer.getTeamPlayerId() == 0) {
//            result.addMessage("Must select player", ResultType.INVALID);
//            return result;
//        }

        List<TeamPlayer> playersOnTeam = findAllByTeam(teamPlayer.getUserTeamId());

        for(TeamPlayer player : playersOnTeam) {
            if(playerRepository.findById(player.getPlayerId()).getPosition() == playerRepository.findById(teamPlayer.getPlayerId()).getPosition()) {
                result.addMessage("can only have one player at each position", ResultType.INVALID);
            }
        }

        return result;
    }

}
