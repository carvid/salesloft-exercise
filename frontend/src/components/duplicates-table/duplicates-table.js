import React from 'react';
import { Icon, Menu, Table } from 'semantic-ui-react';

const table = (props) => (
  <Table celled>
    <Table.Header>
      <Table.Row>
        <Table.HeaderCell colSpan='4'>Person</Table.HeaderCell>
        <Table.HeaderCell colSpan='4'>Duplicate</Table.HeaderCell>
      </Table.Row>
    </Table.Header>

    <Table.Body>
      {props.duplicates.map(tuple => (
        <Table.Row>
          <Table.Cell>{tuple.person.firstName}</Table.Cell>
          <Table.Cell>{tuple.person.lastName}</Table.Cell>
          <Table.Cell>{tuple.person.emailAddress}</Table.Cell>
          <Table.Cell>{tuple.person.title}</Table.Cell>
          <Table.Cell>{tuple.duplicate.firstName}</Table.Cell>
          <Table.Cell>{tuple.duplicate.lastName}</Table.Cell>
          <Table.Cell>{tuple.duplicate.emailAddress}</Table.Cell>
          <Table.Cell>{tuple.duplicate.title}</Table.Cell>
        </Table.Row>
      ))}
    </Table.Body>

    <Table.Footer>
      <Table.Row>
        <Table.HeaderCell colSpan='8'>
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
