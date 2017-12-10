var cal = new CalHeatMap();
cal.init({
  domain: 'month',
  subdomain: 'day',
  cellSize: 15,
  cellRadius: 0,
  domainGutter: 12,
  tooltip: true,
  range: 2,
  data: gon.dwc_calendar
});
