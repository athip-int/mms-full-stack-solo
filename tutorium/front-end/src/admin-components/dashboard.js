import React, { Component } from 'react';

class Dashboard extends Component {
    constructor(props) {
        super(props);
        this.state = {
            detailText: ''
        };
    }

    render() {
        return (
            <div>
                <div class="row">
                    {genDashboardNumberDetail('student')}
                    {genDashboardNumberDetail('tutor')}
                    {genDashboardNumberDetail('tutorRequest')}
                </div>
                <div class="row">
                    {genDashboardNumberDetail('report')}
                    {genDashboardNumberDetail('suspenedAccounts')}
                    {genDashboardNumberDetail('deleteRequest')}
                </div>
            </div>
        );
    }
}

class DashboardNumberDetail extends Component {
    render() {
        return (
            <div class="col-sm-4 col-md-4">
                <h1 style={{
                    paddingBottom: 10,
                    textAlign: "center"
                }}>{this.props.number}</h1>
                <h4 align="center">{this.props.text}</h4>
            </div>
        );
    }
}

function genDashboardNumberDetail(DashboardNumberDetailType) {
    let num = 0, text = '';
    switch(DashboardNumberDetailType)
    {
      case 'student': num = 1; text = 'student'; break;
      case 'tutor': num = 2; text = 'tutor';break;
      case 'tutorRequest': num = 3; text = 'tutorRequest';break;
      case 'report': num = 4; text = 'report';break;
      case 'suspenedAccounts': num = 5; text = 'suspenedAccounts';break;
      case 'deleteRequest': num = 6; text = 'deleteRequest';break;
      default: ;
    }

    return (
      <DashboardNumberDetail 
      number={num} 
      text={text}
    />);
}

export default Dashboard;