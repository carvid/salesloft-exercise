import React from 'react';
import { Container } from 'semantic-ui-react';
import { BrowserRouter as Router, Redirect, Route, Switch } from 'react-router-dom';

import TopMenu from '../top-menu';
import PeopleTable from '../people-table';
import CharsTable from '../chars-table';

const layout = (props) => (
  <div>
    <Router>
      <TopMenu />
      <Container>
        <Switch>
          <Route path="/people">
            <PeopleTable people={props.people}/>
          </Route>
          <Route path="/email-chars">
            <CharsTable results={props.emailChars}/>
          </Route>
          <Route exact path="/">
            <Redirect to="/people" />
          </Route>
        </Switch>
      </Container>
    </Router>
  </div>
);

export default layout;
