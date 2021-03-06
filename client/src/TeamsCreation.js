import React from "react";
//import { useHistory } from 'react-router-dom';
import { withRouter } from "react-router";
import Errors from './Errors'
import Wrigley from "./images/wrigley.jpg"
import AuthContext from './AuthContext'

class TeamsCreation extends React.Component {
	constructor() {
		super();
		this.state = {
			teams: [],
			numberOfTeams: 0,
			teamId: 0,
			name: '', //not sure, but including for now
			numberOfGames: 0,
			userTeamChoiceId: 0,
			errors: [],
		};

		this.teamChangeHandler = this.teamChangeHandler.bind(this);

		//const history = useHistory();
	}

	getTeams = () => {
		fetch(`${process.env.REACT_APP_API_URL}/team`)
			.then((response) => response.json())
			.then((data) => {
				this.setState({
					teams: data,
				})
			});
	};

	componentDidMount() {
		this.getTeams();
	}

	gamesChangeHandler = (event) => {

		this.setState({
			numberOfGames: event.target.value
		});

	}

	numberOfTeamsChangeHandler = (event) => {

		this.setState({
			numberOfTeams: event.target.value
		});
	}

	teamChangeHandler = (event) => {

		this.setState({
			teamId: event.target.value
		});
	}

	createSeasonHandler = (event) => {
		event.preventDefault();
		//console.log(this.props.auth.user.appUserId);
		fetch(`${process.env.REACT_APP_API_URL}/userteam/create`, {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify({
				numberOfTeams: this.state.numberOfTeams,
				numberOfGames: this.state.numberOfGames,
				userTeamChoiceId: this.state.teamId,
				userId: this.context.user.appUserId,				
			}),
		}).then((response) => {
			if (response.status === 200) {
				console.log("Success!");
				this.props.history.push("/draft");
			} else if (response.status === 400) {
				console.log("Errors!");
				response.json().then((data) => console.log(data));
				// const data = await response.json();
				// this.setState({
				//   errors: data,
				// });
			} else {
				throw new Error(`Unexpected response: ${response}`)
			}
		});
	};

	render() {
		const {
			errors,
		} = this.state;

		return (
			<>
				<h1> Create Custom Season</h1><br /><br />

				<Errors errors={errors} />

				<form className="form-group row" onSubmit={this.createSeasonHandler}>

					<div className="col-4 text-danger font-weight-bold">
						<label htmlFor="selectNumberOfTeams">Number of Teams in League</label>
						<select className="form-control" name="numberOfTeams" value={this.state.numberOfTeams}
							onChange={this.numberOfTeamsChangeHandler}>
							<option value=''>-- Select Number --</option>
							<option value='4'>4</option>
							<option value='6'>6</option>
							<option value='8'>8</option>
							<option value='10'>10</option>
							<option value='12'>12</option>
							<option value='14'>14</option>
							<option value='16'>16</option>
						</select>
					</div><br />

					<div className="form-group col-4 text-danger font-weight-bold">
						<label htmlFor="selectNumberOfGames">Number of Games in Season</label>
						<input type="number" className="form-control" name="numberOfGames" value={this.state.numberOfGames}
							onChange={this.gamesChangeHandler} />
					</div><br />

					<div className="form-group col-md-4 text-danger font-weight-bold">
						<label htmlFor="select-container">Choose Team to Control</label>
						<div className="select-container">
							<select className="form-control text-danger font-weight-bold" value={this.state.team}
								onChange={this.teamChangeHandler} >
								<option value=''>-- Select Team --</option>
								{this.state.teams.map((team) =>
									<option key={team.teamId} value={team.teamId}>{team.name}</option>)}
					))
						</select><br />
						</div>
					</div>

					<div className="form-group col-12 ">
						<button type="submit" className="btn  btn-block btn-light ">Create Season</button>
					</div>

				</form>
				<img src={Wrigley} alt="Wrigley Field" height="600" width="1066"></img>
			</>
		);
	}
}

TeamsCreation.contextType = AuthContext;

export default withRouter(TeamsCreation);

