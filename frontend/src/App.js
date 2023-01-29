import React from 'react';
import './App.css';
import Header from './components/Header';
import { Routes, Route, useLocation, BrowserRouter } from 'react-router-dom'
import Home from './pages/Home'
import About from './pages/About'
import MysteryPartners from './pages/MysteryPartners'



class App extends React.Component {

    constructor(props){
        super(props)
    }


    render(){

        return (
            <div className="App">
              <Header />
              <Routes>
                <Route path="/" element={<Home />} />
                <Route path="/about" element={<About />} />
                <Route path="/mystery-partners" element={<MysteryPartners />} />
              </Routes>
            </div>
        );
    }
}

export default App;
