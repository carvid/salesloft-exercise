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

    api.get('/people/duplicates')
      .then(response => {
        this.setState({ duplicates: response.data });
      });
  }

  render() {
    const { children } = this.props;
    const { people, emailChars, duplicates } = this.state;

    return (
      <Layout people={people} emailChars={emailChars} duplicates={duplicates} />
    );
  };
}

export default LayoutContainer;
