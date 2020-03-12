import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { Icon, Menu, Table } from 'semantic-ui-react';

class TopMenu extends Component {
  state = {
    active: 'people',
  }

  render() {
    const { active } = this.state;

    return(
      <Menu inverted>
        <Menu.Item
          key='people'
          name='People'
          as={Link}
          to="people"
          active={active === 'people'}
          onClick={() => { this.setState({active: 'people' }) }}
        />
        <Menu.Item
          key='email-chars'
          name='Email Chars'
          as={Link}
          to="email-chars"
          active={active === 'email-chars'}
          onClick={() => { this.setState({active: 'email-chars' }) }}
        />
        <Menu.Item
          key='duplicates'
          name='Duplicates'
          as={Link}
          to="duplicates"
          active={active === 'duplicates'}
          onClick={() => { this.setState({active: 'duplicates' }) }}
        />
      </Menu>
    );
  }
}

export default TopMenu;
