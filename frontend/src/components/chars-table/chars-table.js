import React from 'react';
import { Table } from 'semantic-ui-react';

const table = (props) => (
  <Table celled>
    <Table.Header>
      <Table.Row>
        <Table.HeaderCell>Character</Table.HeaderCell>
        <Table.HeaderCell>Count</Table.HeaderCell>
      </Table.Row>
    </Table.Header>

    <Table.Body>
      {props.results.map(result => (
        <Table.Row>
          <Table.Cell>{result.character}</Table.Cell>
          <Table.Cell>{result.count}</Table.Cell>
        </Table.Row>
      ))}
    </Table.Body>
  </Table>
);

export default table;
