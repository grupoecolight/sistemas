const ctx = document.getElementById('myChart');
const ctx2 = document.getElementById('myChart2');


new Chart(ctx, {
type: 'bar',
data: {
    labels: ['002-OES', '012-OES', '022-OES', '032-OES', '042-OES', '052-OES', '062-OES', '072-OES', '082-OES', '092-OES'],
    datasets: [{
        label: '18:00:00 PM',
        data: [21, 20, 21, 20, 25, 24, 23, 22, 23, 25],
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
            text: 'Últimos Registros do Ambiente 1',
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
            title: {
                display: true,
                text: '(%)'
            },
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
    data: [21, 23, 17, 16, 24, 29, 26, 31, 35, 41],
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
            text: 'Histórico de Registros do Sensor 032-OES',
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
            title: {
                display: true,
                text: '(%)'
            },
            ticks: {
                stepSize: 10
            }
        }
    }
}
})