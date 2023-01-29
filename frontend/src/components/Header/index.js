import React from 'react'
import { PrimaryNav, MenuLink, Menu, Hamburger } from './NavElement'
const Navbar = () => {
    return (
        <>
        <PrimaryNav>
            <Hamburger />
            <Menu>
                <MenuLink to="/mystery-partners">
                    Home
                </MenuLink>
                <MenuLink to="/mystery-partners">
                    MysteryPartners
                </MenuLink>
                <MenuLink to="/about">
                    About
                </MenuLink>
            </Menu>
        </PrimaryNav>
        </>
    )
}
export default Navbar