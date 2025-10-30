const ctx = document.getElementById('myChart');
const ctx2 = document.getElementById('myChart2');


new Chart(ctx, {
type: 'bar',
data: {
    labels: ['002-NOR', '012-NOR', '022-NOR', '032-NOR', '042-NOR', '052-NOR', '062-NOR', '072-NOR', '082-NOR', '092-NOR'],
    datasets: [{
        label: '18:00:00 PM',
        data: [19, 20, 21, 20, 19, 17, 18, 18, 17, 16],
        borderWidth: 5,
        backgroundColor: '#637CEF',
        color: '#637CEF',
        borderColor: '#637CEF',
        barPercentage: 0.4
    }]
},
options: {
    plugins: {
        title: {
            display: true,
            text: 'Últimos Registros do Ambiente 2',
            font: {
                size: 30
            }
        }
    },
    scales: {
        y: {
            beginAtZero: true,
            min: 0,
            max: 60,
            ticks: {
                stepSize: 10
            }
        }
    }
}
})

new Chart(ctx2, {
type: 'line',
data: {
    labels: ['08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00', '12:30'],
    datasets: [{
    label: '13/10/2025',
    data: [41, 43, 45, 47, 49, 53, 51, 44, 31, 33],
    borderWidth: 5,
    backgroundColor: '#637CEF',
    color: '#637CEF',
    borderColor: '#637CEF',
    tension: 0.3
    }]
},
options: {
    plugins: {
        title: {
            display: true,
            text: 'Histórico de Registros do Sensor 002-NOR',
            font: {
                size: 30
            }
        }
    },
    scales: {
        y: {
            beginAtZero: true,
            min: 0,
            max: 60,
            ticks: {
                stepSize: 10
            }
        }
    }
}
})