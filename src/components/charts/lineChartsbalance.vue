<template>
  <div>
    <div ref="linechart" id="lineChart" style="height: 300px;"></div>
  </div>
</template>

<script>
export default {
  name: "LineChart",
  data() {
    return {
      model: false,
      options: {
        color: ['#4c38f2'],
        tooltip: {
            show: true,
         
        },
       "title": {"show": true, "textStyle": {"color": "#4c38f2", "fontFamily": "sans-serif"}},
        grid: {
            containLabel: true,
          left: '3%',
          right: '4%',
          bottom: '20%',
          top: '5%',
          containLabel: true
        },
        xAxis: [
          {
            type: 'category',
            boundaryGap: false,
            data: ['00:00', '6:00', '12:00', '18:00', '00:00']
          }
        ],
        yAxis: [
          {
            type: 'value'
          }
        ],
        series: [
          {
            name: 'Line 1',
            type: 'line',
            stack: 'Total',
            smooth: true,
            lineStyle: {
              width: 2
            },
            
            areaStyle: {
              opacity: 0.2,
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                offset: 0,
                color: 'rgba(76 56 242)'
              }, {
                offset: 1,
                color: 'rgba(76 56 242 / 60%)'
              }])
            },
            emphasis: {
              focus: 'series'
            },
            data: [1000, 2000, 2500, 1050, 3000]
          },
          
        ]
      },
      line_chart: null
    }
  },
  mounted() {
    this.init();
  },
  watch: {
    '$q.dark.isActive': function () {
      this.init();
    }
  },
  methods: {
    init() {
      let lineChart = document.getElementById('lineChart');
      echarts.dispose(lineChart);
      let theme = this.model ? 'dark' : 'light';
      this.line_chart = echarts.init(lineChart, theme);
      this.line_chart.setOption(this.options)
    },
    onResize() {
      if (this.line_chart) {
        this.line_chart.resize();
      }
    }
  }
}
</script>

<style scoped>
</style>
