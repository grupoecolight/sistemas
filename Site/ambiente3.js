const ctx = document.getElementById('myChart');
const ctx2 = document.getElementById('myChart2');


new Chart(ctx, {
type: 'bar',
data: {
    labels: ['002-SUL', '012-SUL', '022-SUL', '032-SUL', '042-SUL', '052-SUL', '062-SUL', '072-SUL', '082-SUL', '092-SUL'],
    datasets: [{
        label: '18:00:00 PM',
        data: [41, 44, 49, 45, 46, 41, 43, 42, 44, 46],
        borderWidth: 5,
        backgroundColor: '#FFD535',
        color: '#FFD535',
        borderColor: '#FFD535',
        barPercentage: 0.4
    }]
},
options: {
    plugins: {
        title: {
            display: true,
            text: 'Últimos Registros do Ambiente 3',
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
    data: [21, 22, 25, 24, 28, 36, 39, 44, 45, 47],
    borderWidth: 5,
    backgroundColor: '#FFD535',
    color: '#FFD535',
    borderColor: '#FFD535',
    tension: 0.3
    }]
},
options: {
    plugins: {
        title: {
            display: true,
            text: 'Histórico de Registros do Sensor 052-SUL',
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