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
    lower: "Moins de {min} {name}, Master Lao Zhi a du prendre une pause",
    inner: "Entre {down} et {up} {name}, pas mal",
    upper: "Plus de {max} {name}, fuyez !"
  },
  domainLabelFormat: "%m-%Y"
});
