import React from 'react'
import MysteryPartner from '../components/MysteryPartner/index'

class MysteryPartners extends React.Component {
    constructor(props){
        super(props)
        this.state = {
            items: []
        }
    }

    componentDidMount(){
        fetch('http://0.0.0.0:3000/')
            .then(function(response){
                return response.json()
            }).then(responseData => {
            this.setState({
                items: responseData.results
            })
        }).catch(error => {
            alert("Error ");
        })
    }

    render() {
        let items = this.state.items
        let root_path = "http://0.0.0.0:3000"

        var MysteryLunchPartners = function () {
            return (
                <div>
                    <h1> Mystery Lunch Partners </h1>
                    {items.map(function (item) {
                        let id = item.id
                        let name1 = item.employee1.name
                        let name2 = item.employee2.name

                        let img1 = item.employee1.img
                        let img2 = item.employee2.img

                        let department1 = item.employee1.department
                        let department2 = item.employee2.department

                        var profile1 = {id: id, name: name1, img: root_path + img1, department: department1 }
                        var profile2 = {id: id, name: name2, img: root_path + img2, department: department2 }
                        return (
                            <div>
                                <MysteryPartner profile1={profile1} profile2={profile2}/>
                                <hr/>
                            </div>
                        )
                    })}
                </div>
            )

        }

        return (
            <div>
                <MysteryLunchPartners/>
            </div>
        )
    }
}

export default MysteryPartners