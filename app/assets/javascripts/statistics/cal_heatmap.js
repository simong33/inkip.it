var cal = new CalHeatMap();
cal.init({
  domain: 'month',
  subdomain: 'day',
  cellSize: 10,
  cellRadius: 0,
  domainGutter: 6,
  tooltip: true,
  range: 4,
  data: gon.dwc_calendar,
  itemName: ["mot", "mots"],
  subDomainTitleFormat: {
      empty: "Pas d'écriture le {date}",
      filled: "Vous avez écrit {count} {name} le {date}"
    },
  legendTitleFormat: {
    lower: "Moins de {min} {name}",
    inner: "Entre {down} et {up} {name}",
    upper: "Plus de {max} {name}, bravo !"
  },
  legend: [100, 500, 1000, 2000, 5000],
  domainLabelFormat: "%m-%Y"
});
