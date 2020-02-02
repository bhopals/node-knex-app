import React from 'react';
import ListItem from './ListItem';
import ListItems from './ListItems';

class ItemBody extends React.Component  {
  
  render() {
    return(
      <ListItems>
        <ListItem text="Hello!!! BHOPAL"></ListItem>
      </ListItems>
      )
  }

}

export default ItemBody;