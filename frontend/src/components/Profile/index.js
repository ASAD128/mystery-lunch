import React from 'react';
import '../../index.css';
import './index.css';
class Profile extends React.Component {

    constructor(props) {
        super(props)
    }

    render() {

        var Friendly = function (props) {

            var profile = props.profile

            return (
                <div className="profile1">
                    <Avatar img={profile.img}/>
                    <ProfileName name={profile.name}/>
                    <Department department={profile.department}/>
                </div>
            );
        }


        var Avatar = function (props) {
            return (
                <img src={props.img} className="profile-img"></img>
            );
        }

        var ProfileName = function (props) {
            return (
                <h3 className="name">{props.name}</h3>
            );
        }

        var Department = function (props) {
            return (
                <h3 className="department">{props.department}</h3>
            );
        }

        var SocialMedia = function () {
            return (
                <div>
                    <Like/>
                    <Share/>
                    <Add/>
                </div>
            );
        }

        var iconStyle = {
            margin: 20
        }

        function Like() {
            return (
                <i className="fa fa-thumbs-o-up" aria-hidden="true" style={iconStyle}></i>
            );
        }

        function Share() {
            return (
                <i className="fa fa-share-alt" aria-hidden="true" style={iconStyle}></i>
            );
        }

        function Add() {
            return (
                <i className="fa fa-users" aria-hidden="true" style={iconStyle}></i>
            );
        }


        var profile = this.props.data

        return (

                <Friendly profile={profile}/>

        )
    }
}

export default Profile;