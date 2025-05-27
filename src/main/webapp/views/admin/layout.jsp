<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<c:set var="assetPath" value="${pageContext.request.contextPath}/assets/admin" />


  <!-- Fonts and icons -->
  <script src="${assetPath}/js/plugin/webfont/webfont.min.js"></script>
  <script>
    WebFont.load({
      google: { families: ["Public Sans:300,400,500,600,700"] },
      custom: {
        families: [
          "Font Awesome 5 Solid",
          "Font Awesome 5 Regular",
          "Font Awesome 5 Brands",
          "simple-line-icons",
        ],
        urls: ["${assetPath}/css/fonts.min.css"],
      },
      active: function () {
        sessionStorage.fonts = true;
      },
    });
  </script>

  <!-- CSS Files -->
  <link rel="stylesheet" href="${assetPath}/css/bootstrap.min.css" />
  <link rel="stylesheet" href="${assetPath}/css/plugins.min.css" />
  <link rel="stylesheet" href="${assetPath}/css/kaiadmin.min.css" />
  
</head>
<body>
	<div class="wrapper">
		<jsp:include page="sidebar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="navbar.jsp"></jsp:include>
			<jsp:include page="${view}"></jsp:include>
			<jsp:include page="footer.jsp"></jsp:include>
		</div>
	</div>
	
	
	
	
	
	
	
<!--   Core JS Files   -->
  <script src="${assetPath}/js/core/jquery-3.7.1.min.js"></script>
  <script src="${assetPath}/js/core/popper.min.js"></script>
  <script src="${assetPath}/js/core/bootstrap.min.js"></script>

  <!-- jQuery Scrollbar -->
  <script src="${assetPath}/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

  <!-- Chart JS -->
  <script src="${assetPath}/js/plugin/chart.js/chart.min.js"></script>

  <!-- jQuery Sparkline -->
  <script src="${assetPath}/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

  <!-- Chart Circle -->
  <script src="${assetPath}/js/plugin/chart-circle/circles.min.js"></script>

  <!-- Datatables -->
  <script src="${assetPath}/js/plugin/datatables/datatables.min.js"></script>

  <!-- Bootstrap Notify -->
  <script src="${assetPath}/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

  <!-- jQuery Vector Maps -->
  <script src="${assetPath}/js/plugin/jsvectormap/jsvectormap.min.js"></script>
  <script src="${assetPath}/js/plugin/jsvectormap/world.js"></script>

  <!-- Sweet Alert -->
  <script src="${assetPath}/js/plugin/sweetalert/sweetalert.min.js"></script>

  <!-- Kaiadmin JS -->
   <script src="${assetPath}/js/kaiadmin.min.js"></script>

  <script>
    $("#lineChart").sparkline([102, 109, 120, 99, 110, 105, 115], {
      type: "line",
      height: "70",
      width: "100%",
      lineWidth: "2",
      lineColor: "#177dff",
      fillColor: "rgba(23, 125, 255, 0.14)",
    });

    $("#lineChart2").sparkline([99, 125, 122, 105, 110, 124, 115], {
      type: "line",
      height: "70",
      width: "100%",
      lineWidth: "2",
      lineColor: "#f3545d",
      fillColor: "rgba(243, 84, 93, .14)",
    });

    $("#lineChart3").sparkline([105, 103, 123, 100, 95, 105, 115], {
      type: "line",
      height: "70",
      width: "100%",
      lineWidth: "2",
      lineColor: "#ffa534",
      fillColor: "rgba(255, 165, 52, .14)",
    });
  </script>
  
  <script>
      $(document).ready(function () {
        $("#basic-datatables").DataTable({});

        $("#multi-filter-select").DataTable({
          pageLength: 5,
          initComplete: function () {
            this.api()
              .columns()
              .every(function () {
                var column = this;
                var select = $(
                  '<select class="form-select"><option value=""></option></select>'
                )
                  .appendTo($(column.footer()).empty())
                  .on("change", function () {
                    var val = $.fn.dataTable.util.escapeRegex($(this).val());

                    column
                      .search(val ? "^" + val + "$" : "", true, false)
                      .draw();
                  });

                column
                  .data()
                  .unique()
                  .sort()
                  .each(function (d, j) {
                    select.append(
                      '<option value="' + d + '">' + d + "</option>"
                    );
                  });
              });
          },
        });

        // Add Row
        $("#add-row").DataTable({
          pageLength: 5,
        });

        var action =
          '<td> <div class="form-button-action"> <button type="button" data-bs-toggle="tooltip" title="" class="btn btn-link btn-primary btn-lg" data-original-title="Edit Task"> <i class="fa fa-edit"></i> </button> <button type="button" data-bs-toggle="tooltip" title="" class="btn btn-link btn-danger" data-original-title="Remove"> <i class="fa fa-times"></i> </button> </div> </td>';

        $("#addRowButton").click(function () {
          $("#add-row")
            .dataTable()
            .fnAddData([
              $("#addName").val(),
              $("#addPosition").val(),
              $("#addOffice").val(),
              action,
            ]);
          $("#addRowModal").modal("hide");
        });
      });
    </script>
    
    <script>
	(function () {
	  'use strict'

	  var forms = document.querySelectorAll('.needs-validation')

	  Array.prototype.slice.call(forms)
	    .forEach(function (form) {
	      form.addEventListener('submit', function (event) {
	        if (!form.checkValidity()) {
	          event.preventDefault()
	          event.stopPropagation()
	        }

	        form.classList.add('was-validated')
	      }, false)
	    })
	})()
	</script>
	
	<script>
	var htmlLegendsChart = document
    .getElementById("htmlLegendsChart")
    .getContext("2d");
	
    // Chart with HTML Legends

    var gradientStroke = htmlLegendsChart.createLinearGradient(
      500,
      0,
      100,
      0
    );
    gradientStroke.addColorStop(0, "#177dff");
    gradientStroke.addColorStop(1, "#80b6f4");

    var gradientFill = htmlLegendsChart.createLinearGradient(500, 0, 100, 0);
    gradientFill.addColorStop(0, "rgba(23, 125, 255, 0.7)");
    gradientFill.addColorStop(1, "rgba(128, 182, 244, 0.3)");

    var gradientStroke2 = htmlLegendsChart.createLinearGradient(
      500,
      0,
      100,
      0
    );
    gradientStroke2.addColorStop(0, "#f3545d");
    gradientStroke2.addColorStop(1, "#ff8990");

    var gradientFill2 = htmlLegendsChart.createLinearGradient(500, 0, 100, 0);
    gradientFill2.addColorStop(0, "rgba(243, 84, 93, 0.7)");
    gradientFill2.addColorStop(1, "rgba(255, 137, 144, 0.3)");

    var gradientStroke3 = htmlLegendsChart.createLinearGradient(
      500,
      0,
      100,
      0
    );
    gradientStroke3.addColorStop(0, "#fdaf4b");
    gradientStroke3.addColorStop(1, "#ffc478");

    var gradientFill3 = htmlLegendsChart.createLinearGradient(500, 0, 100, 0);
    gradientFill3.addColorStop(0, "rgba(253, 175, 75, 0.7)");
    gradientFill3.addColorStop(1, "rgba(255, 196, 120, 0.3)");

    var myHtmlLegendsChart = new Chart(htmlLegendsChart, {
      type: "line",
      data: {
        labels: [
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "Jun",
          "Jul",
          "Aug",
          "Sep",
          "Oct",
          "Nov",
          "Dec",
        ],
        datasets: [
          {
            label: "Subscribers",
            borderColor: gradientStroke2,
            pointBackgroundColor: gradientStroke2,
            pointRadius: 0,
            backgroundColor: gradientFill2,
            legendColor: "#f3545d",
            fill: true,
            borderWidth: 1,
            data: [
              154, 184, 175, 203, 210, 231, 240, 278, 252, 312, 320, 374,
            ],
          },
          {
            label: "New Visitors",
            borderColor: gradientStroke3,
            pointBackgroundColor: gradientStroke3,
            pointRadius: 0,
            backgroundColor: gradientFill3,
            legendColor: "#fdaf4b",
            fill: true,
            borderWidth: 1,
            data: [
              256, 230, 245, 287, 240, 250, 230, 295, 331, 431, 456, 521,
            ],
          },
          {
            label: "Active Users",
            borderColor: gradientStroke,
            pointBackgroundColor: gradientStroke,
            pointRadius: 0,
            backgroundColor: gradientFill,
            legendColor: "#177dff",
            fill: true,
            borderWidth: 1,
            data: [
              542, 480, 430, 550, 530, 453, 380, 434, 568, 610, 700, 900,
            ],
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
          display: false,
        },
        tooltips: {
          bodySpacing: 4,
          mode: "nearest",
          intersect: 0,
          position: "nearest",
          xPadding: 10,
          yPadding: 10,
          caretPadding: 10,
        },
        layout: {
          padding: { left: 15, right: 15, top: 15, bottom: 15 },
        },
        scales: {
          yAxes: [
            {
              ticks: {
                fontColor: "rgba(0,0,0,0.5)",
                fontStyle: "500",
                beginAtZero: false,
                maxTicksLimit: 5,
                padding: 20,
              },
              gridLines: {
                drawTicks: false,
                display: false,
              },
            },
          ],
          xAxes: [
            {
              gridLines: {
                zeroLineColor: "transparent",
              },
              ticks: {
                padding: 20,
                fontColor: "rgba(0,0,0,0.5)",
                fontStyle: "500",
              },
            },
          ],
        },
        legendCallback: function (chart) {
          var text = [];
          text.push('<ul class="' + chart.id + '-legend html-legend">');
          for (var i = 0; i < chart.data.datasets.length; i++) {
            text.push(
              '<li><span style="background-color:' +
                chart.data.datasets[i].legendColor +
                '"></span>'
            );
            if (chart.data.datasets[i].label) {
              text.push(chart.data.datasets[i].label);
            }
            text.push("</li>");
          }
          text.push("</ul>");
          return text.join("");
        },
      },
    });

    var myLegendContainer = document.getElementById("myChartLegend");

    // generate HTML legend
    myLegendContainer.innerHTML = myHtmlLegendsChart.generateLegend();

    // bind onClick event to all LI-tags of the legend
    var legendItems = myLegendContainer.getElementsByTagName("li");
    for (var i = 0; i < legendItems.length; i += 1) {
      legendItems[i].addEventListener("click", legendClickCallback, false);
    }
	</script>
</body>
</html>