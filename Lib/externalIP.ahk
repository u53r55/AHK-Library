externalIP(ip:="me"){
    ipInfo:={}
    if(ip="me" || regExMatch(ip,"^(\d{1,3}\.){3}\d{1,3}$")){
        ipInfoList:=["ip","city","country","region","isp","latitude","longitude","hostname","asn"]
        ipPage:=urlDownloadToVar("http://dazzlepod.com/ip/" . ip . ".json")
        
        for i,a in ipInfoList{
            regExMatch(ipPage,"Um)""" . (a="isp"?"organization":a) . """: ""?\K[^"",]+(?=""|,)",t)
            ipInfo.insert(a,t)
        }
        return ipInfo
    }else{
        ipInfoList:=["ip","city","country","region","isp","loc","hostname","postal"]
        ipPage:=urlDownloadToVar("http://ipinfo.io/" . ip . "/json")
        
        for i,a in ipInfoList{
            regExMatch(ipPage,"U)""" . (a="isp"?"org":a) . """: ""\K[^""]+(?="")",t)
            if(a="loc")
                loop,parse,t,`,
                    ipInfo.insert(a_index=1?"latitude":"longitude",a_loopField)
            else
                ipInfo.insert(a,t)
        }
        return ipInfo
    }
}
