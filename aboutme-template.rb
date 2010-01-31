$template = <<-EOF

<!DOCTYPE html PUBLIC
  "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.8.0r4/build/fonts/fonts-min.css">
	<style type="text/css">
		.verticallabel { 
			text-align: right;
			padding-right: 7px;
		}
		.verticalbar { 
			background-color: #B10000;
			height: 15px;
		}
		
		table.horizontal {
			text-align: center;
		}
		.horizontalbar {
			background-color: #B10000;
			width: 25px;
		}
	</style>
</head>

<body>
	<h1>about:me || Opera Style</h1>

	<h2>Info</h2>
	<p><b>Total number of sites:</b> <%= total_count %></p>
	<p><b>Entries from:</b> <%= entry[0][:time] %></p>
	
	<h2>Top Sites</h2>
	<table class="vertical">
	<% for i in sites_freq[0..20] %>
		<tr>
			<td class="verticallabel"><%= i[0] %></td>
			<td>
				<div class="verticalbar" style="width:<%= i[1].to_f/sites_freq[0][1].to_f*400.0 %>px" />
				<div style="position: relative; left:<%= i[1].to_f/sites_freq[0][1].to_f*400.0 + 5%>px"><%= i[1] %></div>
			</td>
		</tr>
	<% end %>
	</table>
	
	<h2>Hourly</h2>
	<table class="horizontal">
		<tr>
		<% for i in times_freq %>
			<td style="vertical-align: bottom">
				<div class="horizontalbar" style="height:<%= i[1].to_f/max_times_freq.to_f*100.0 %>px" />
				<div style="position: relative; bottom:25px"><%= i[1] %></div>
			</td>
		<% end %>
		</tr>
		<tr>
		<% for i in times_freq %>
			<td><%= i[0] %></td>
		<% end %>
		</tr>
	<table>
	
	<h2>Daily</h2>
	<table class="horizontal">
		<tr>
		<% for i in days_freq %>
			<td style="vertical-align: bottom">
				<div class="horizontalbar" style="height:<%= i[1].to_f/max_days_freq.to_f*100.0 %>px" />
				<div style="position: relative; bottom:25px"><%= i[1] %></div>
			</td>
		<% end %>
		</tr>
		<tr>
		<% for i in days_freq %>
			<td><%= Time::RFC2822_DAY_NAME[i[0]] %></td>
		<% end %>
		</tr>
	<table>
</body>

</html>

EOF
  