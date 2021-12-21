<template>
  <div>
        <div ref="barchart" id="barChart" style="height: 300px;"></div>
  </div>
</template>

<script>
import {defineComponent} from 'vue';
import {ref} from 'vue';

export default defineComponent({
  name: "BarChart",
  setup() {
    return {
      model: ref(false),
      options: {
        color: ['#4c38f2', '#4c38f273'],
        legend: {
          bottom: 10,
        },
        tooltip: {},
        dataset: {
          source: [
            ['product', 'Received', 'Invested'],
            ['Agosto', 1000, 800],
            ['Septiembre', 2000, 1200,],
            ['Octubre', 5000, 6000],
            ['Noviembre', 4000, 2500]
          ]
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '20%',
          top: '5%',
          containLabel: true
        },
        xAxis: {type: 'category'},
        yAxis: {},
        // Declare several bar series, each will be mapped
        // to a column of dataset.source by default.
        series: [
          {type: 'bar'},
          {type: 'bar'},
        ]
      },
      bar_chart: ref(null),
    }
  },
  mounted() {
    this.init();
  },
  methods: {
    SaveImage() {
      const linkSource = this.bar_chart.getDataURL();
      const downloadLink = document.createElement('a');
      document.body.appendChild(downloadLink);
      downloadLink.href = linkSource;
      downloadLink.target = '_self';
      downloadLink.download = 'BarChart.png';
      downloadLink.click();
    },
    init() {
      let barChart = document.getElementById('barChart');
      this.bar_chart = echarts.init(barChart,'light');
      this.bar_chart.setOption(this.options)
    },
    onResize() {
      if (this.bar_chart) {
        this.bar_chart.resize();
      }
    }
  }
})
</script>

<style scoped>
</style>
