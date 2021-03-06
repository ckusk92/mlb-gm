import React, { useState, useContext } from 'react';
import { Link, useHistory } from 'react-router-dom';

import AuthContext from './AuthContext';
import Errors from './Errors';

export default function Register() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [errors, setErrors] = useState([]);

  const auth = useContext(AuthContext);
  const history = useHistory();

  const handleSubmit = async (event) => {
    event.preventDefault();

    const response = await fetch(`${process.env.REACT_APP_API_URL}/create_account`, {
      method: 'POST',
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        username,
        password
      })
    });
    
    if (response.status === 201) {
     //const { jwt_token } = await response.json();
    
    //   {
    //     "jwt_token": "eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjYWxvcmllLXRyYWNrZXIiLCJzdWIiOiJzbWFzaGRldjUiLCJhdXRob3JpdGllcyI6IlJPTEVfVVNFUiIsImV4cCI6MTYwNTIzNDczNH0.nwWJtPYhD1WlZA9mGo4n5U0UQ3rEW_kulilO2dEg7jo"
    //   }
    
      //auth.login(jwt_token);
    
      history.push('/login');
    } else if (response.status === 400) {
      setErrors(['Registration failed.']);
    } else {
      setErrors(['Unknown error.']);
    }
  };

  return (
    <div>
      <h2>Register</h2>
      <Errors errors={errors} />
      <form onSubmit={handleSubmit}>
        <div>
          <label>Username:</label>
          <input type="text" onChange={(event) => setUsername(event.target.value)} />
        </div>
        <div>
          <label>Password:</label>
          <input type="password" onChange={(event) => setPassword(event.target.value)} />
        </div>
        <br />
        <div>
          <button className="btn" type="submit">Register</button>
        </div>
        <br />
      </form>
    </div>
  );
}