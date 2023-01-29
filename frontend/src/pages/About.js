import React from 'react'
import Profile from '../components/Profile';

function About() {
    var profile = {id: 1, name: "Asad Hussain", img:"https://avatars.githubusercontent.com/u/22412472", department: "Engineering"}

    return (
        <div>
            <Profile data={profile}/>
        </div>
    )
}
export default About