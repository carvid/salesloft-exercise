import React, { Component } from 'react';
import api from '../../api';
import Layout from './layout';

class LayoutContainer extends Component {
  state = {
    people: [],
    emailChars: [],
    duplicates: [],
  };

  componentDidMount() {
    api.get('/people')
      .then(response => {
        this.setState({ people: response.data });
      });

    api.get('/people/email_characters')
      .then(response => {
        this.setState({ emailChars: response.data });
      });
  }

  render() {
    const { children } = this.props;
    const { people, emailChars } = this.state;

    return (
      <Layout people={people} emailChars={emailChars} />
    );
  };
}

export default LayoutContainer;
