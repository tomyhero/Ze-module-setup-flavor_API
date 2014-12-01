<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="google" content="notranslate">
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta name="robots" content="noindex,nofollow" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="Thu, 1 Jan 1970 00:00:00 GMT" />

<title>[% loc('Operation System') %]</title>
<link rel="stylesheet" href="/static/css/normalize.css">
<link rel="stylesheet" href="/static/css/base.css">
</head>
[% IF operator_obj %]
<div class="login-bar">
<b>[% operator_obj.op_name %]</b> : <small>[% operator_obj.op_timezone %] - [% requested_at.set_time_zone(operator_obj.op_timezone).fmt_datetime() %]</small>
<a href="/auth/logout">logout</a>
</div>
[% INCLUDE 'menu.inc' %]
[% END %]

[% INCLUDE 'error.inc' %]
