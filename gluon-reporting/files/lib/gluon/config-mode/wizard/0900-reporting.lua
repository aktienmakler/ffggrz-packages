local cbi = require "luci.cbi"
local uci = luci.model.uci.cursor()

local M = {}

function M.section(form)
        local s = form:section(cbi.SimpleSection, nil, [[Stellen Sie die Benachrichtigungen ein, die vom Monitoring-System an Ihre Kontaktadresse versandt werden.]])

        local o
          o = s:option(cbi.Flag, "_use_reporting", "Reports erhalten")
        o.default = uci:get_first("gluon-reporting", "client", "use_reporting", o.disabled)
        o.rmempty = false

        o = s:option(cbi.Value, "_nodeName", "nodeName")
        o.value = uci:get_first("gluon-provisioning", "client", "nodeName")
        o.rmempty = false
        
        
local o = s:option(ListValue, "frequency", translate("Report frequency"))
o.default = ""
o:value("", translate("Chose frequency"))
o:value("d", translate("daily"))
o:value("w", translate("weekly"))
o:value("m", translate("monthly"))
o:depends("_use_reporting", "1")

        o = s:option(cbi.Value, "_nodePassword", "nodePassword")
        o.value = uci:get_first("gluon-provisioning", "client", "nodePassword")
        o.rmempty = false
        o:depends("_use_provisioning", "1")

        o = s:option(cbi.Value, "_uuid", "UUID")
        o.value = uci:get_first("gluon-provisioning", "client", "UUID")

end

function M.handle(data)
        local sname = uci:get_first("gluon-provisioning", "client")
        uci:set("gluon-provisioning", sname, "use_provisioning", data._use_provisioning)

        local uuid = uci:get_first("gluon-provisioning", "client", "UUID")
        if uuid == nil then
                f = assert(io.popen("cat /proc/sys/kernel/random/uuid"))
                local result
                for line in f:lines() do
                        result = line
                end
                uci:set("gluon-provisioning", sname, "UUID", result)
        end
        if data._use_provisioning and data._nodeName ~= nil and data._nodePassword ~= nil then
                uci:set("gluon-provisioning", sname, "nodeName", data._nodeName)
                uci:set("gluon-provisioning", sname, "nodePassword", data._nodePassword)
        else
                uci:delete("gluon-provisioning", sname, "nodeName")
                uci:delete("gluon-provisioning", sname, "nodePassword")
        end

        uci:save("gluon-provisioning")
        uci:commit("gluon-provisioning")
end

return M
