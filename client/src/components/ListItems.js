import React from 'react';

const ListItems = ({children}) => {
  return(
    <ul class="list-group">
      {children}
    </ul>
  )
}


export default ListItems;