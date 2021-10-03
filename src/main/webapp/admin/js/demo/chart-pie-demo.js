// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

$.ajax({
		url:path+"hjy/admin/payType",
		type:"get",
		dataType:"json",
		success:function(data){
			for(i=0;i<=1;i++){
				if(data.list[i].pmethod=="undefined"){
					data.list[i].pmethod=0;
				}
			}
			// Pie Chart Example
			var ctx = document.getElementById("myPieChart");
			var myPieChart = new Chart(ctx, {
			  type: 'doughnut',
			  data: {
			    labels: [data.list[0].pmethod, data.list[1].pmethod],
			    datasets: [{
			      data: [data.list[0].cnt/(data.list[0].cnt+data.list[1].cnt)*100 ,data.list[1].cnt/(data.list[0].cnt+data.list[1].cnt)*100],
			      backgroundColor: ['#4e73df', '#1cc88a'],
			      hoverBackgroundColor: ['#2e59d9', '#17a673'],
			      hoverBorderColor: "rgba(234, 236, 244, 1)",
			    }],
			  },
			  options: {
			    maintainAspectRatio: false,
			    tooltips: {
			      backgroundColor: "rgb(255,255,255)",
			      bodyFontColor: "#858796",
			      borderColor: '#dddfeb',
			      borderWidth: 1,
			      xPadding: 15,
			      yPadding: 15,
			      displayColors: false,
			      caretPadding: 10,
			    },
			    legend: {
			      display: false
			    },
			    cutoutPercentage: 80,
			  },
			});
		}
	});
	
