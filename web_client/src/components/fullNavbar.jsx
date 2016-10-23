import React from 'react';
import { Navbar, Nav, NavItem, NavDropdown, MenuItem } from 'react-bootstrap';
import { Link } from 'react-router';
import { LinkContainer } from 'react-router-bootstrap';

export class FullNavbar extends React.Component {
  render = () => {
    return (
      <Navbar inverse>
        <Navbar.Header>
          <Navbar.Brand>
            <Link to={`/`}>Portfolio</Link>
          </Navbar.Brand>
          <Navbar.Toggle />
        </Navbar.Header>
        <Navbar.Collapse>
          <Nav>
            <LinkContainer to={`/trades`} >
              <NavItem eventKey={1} href="/trades">Trades</NavItem>
            </LinkContainer>
          </Nav>
          <Nav pullRight>
            <NavItem eventKey={1} href="#">Log In</NavItem>
            <NavItem eventKey={2} href="#">Sign Up</NavItem>
          </Nav>
        </Navbar.Collapse>
      </Navbar>
    )
  }
}
