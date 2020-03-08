import React from 'react';
import { Icon, Menu, Table } from 'semantic-ui-react';

const table = (props) => (
  <Table celled>
    <Table.Header>
      <Table.Row>
        <Table.HeaderCell>First Name</Table.HeaderCell>
        <Table.HeaderCell>Last Name</Table.HeaderCell>
        <Table.HeaderCell>Email</Table.HeaderCell>
        <Table.HeaderCell>Title</Table.HeaderCell>
      </Table.Row>
    </Table.Header>

    <Table.Body>
      {props.people.map(person => (
        <Table.Row>
          <Table.Cell>{person.firstName}</Table.Cell>
          <Table.Cell>{person.lastName}</Table.Cell>
          <Table.Cell>{person.emailAddress}</Table.Cell>
          <Table.Cell>{person.title}</Table.Cell>
        </Table.Row>
      ))}
    </Table.Body>

    <Table.Footer>
      <Table.Row>
        <Table.HeaderCell colSpan='4'>
          <Menu floated='right' pagination>
            <Menu.Item as='a' icon>
              <Icon name='chevron left' />
            </Menu.Item>
            <Menu.Item as='a' icon>
              <Icon name='chevron right' />
            </Menu.Item>
          </Menu>
        </Table.HeaderCell>
      </Table.Row>
    </Table.Footer>
  </Table>
);

export default table;
