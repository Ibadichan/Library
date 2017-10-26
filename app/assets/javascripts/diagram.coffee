$ ->
  ctxP = document.getElementById('pieChart').getContext('2d')
  readed = $('canvas#pieChart').attr('data-readed')
  left = 100 - readed

  myPieChart = new Chart(ctxP,
    type: 'pie'
    data:
      labels: ['remaining', 'readed']
      datasets: [ { data: [ left, readed ], backgroundColor: [ '#ed2c45', '#1aca39' ] } ]
  )

  document.getElementById('pieChart').style.width = '500px'
  document.getElementById('pieChart').style.height = '250px'
