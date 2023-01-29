import Profile from '../Profile';
import './index.css';

function MysteryPartner(props) {
    var profile1 = props.profile1
    var profile2 = props.profile2

    var MysteryPairs = function () {

        return (
            <div className="profile">
                <Profile data={profile1}/>
                <Profile data={profile2}/>
            </div>
        );
    }
    return (
        <div className="spacer">
            <MysteryPairs/>
        </div>
    )
}
export default MysteryPartner