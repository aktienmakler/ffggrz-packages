local cbi = require "luci.cbi"
local uci = luci.model.uci.cursor()

local M = {}

function M.section(form)
	local s = form:section(cbi.SimpleSection, nil, [[Stellen Sie die Benachrichtigungen ein, die vom Monitoring-System an Ihre Kontaktadresse versandt werden.]])

	local o
	o = s:option(cbi.Flag, "_use_reporting", "Reports erhalten")
	o.default = uci:get_first("gluon-reporting", "reporting", "use_reporting", o.disabled)
	o.rmempty = false

	o = s:option(ListValue, "_report_frequency", translate("Report frequency"))
	o.default = uci:get_first("gluon-reporting", "reporting", "report_frequency", "m")
	o.value("", translate("Chose frequency"))
	o.value("d", translate("daily"))
	o.value("w", translate("weekly"))
	o.value("m", translate("monthly"))
	o.depends("_use_reporting", "1")
	o.widget = "select"

	o = s:option(cbi.Flag, "_report_error", translate("Report error"))
	o.default = uci:get_first("gluon-reporting", "reporting", "report_error", 1)
	o.depends("_use_reporting", "1")

	o = s:option(cbi.Flag, "_report_recovery", translate("Report recovery"))
	o.default = uci:get_first("gluon-reporting", "reporting", "report_recovery", 0)
	o.depends("_use_reporting", "1")

end

function M.handle(data)
        local sname = uci:get_first("gluon-reporting", "report")
        uci:set("gluon-reporting", sname, "use_reporting", data._use_reporting)
        uci:set("gluon-reporting", sname, "report_frequency", data._report_frequency)
        uci:set("gluon-reporting", sname, "report_error", data._report_error)
        uci:set("gluon-reporting", sname, "report_recovery", data._report_recovery)

        uci:save("gluon-reporting")
        uci:commit("gluon-reporting")
end

return M
