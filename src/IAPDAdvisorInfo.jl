module IAPDAdvisorInfo
    

using HTTP
using JSON3

export search_iapd

"""
    search_iapd(firm_name)

Retrieves the record on IAPD matching the search string (Firm Name, CRD number, or SEC Number). When looking for SEC-Numbers import them as following XXX-XXXXX (for example 801-69413).

Returns a `NamedTuple` with the following keys:
 - name: Vector of the names of the matched firms
 - crd: Vector of the matched firms CRD Numbers
 - snum: Vector of the SEC-Numbers
 - other_names: Vector of a vector of other names the match firms conudcts business under
"""
function search_iapd(firm_name)
    res = HTTP.get("https://api.adviserinfo.sec.gov/search/firm?query=$(replace(firm_name, " "=>"%20"))&hl=true&nrows=12&start=0&r=25&sort=score%2Bdesc&wt=json");
    json_res = JSON3.read(res.body)
    if json_res.hits.total >0
        crd = Vector{String}(undef,size(json_res.hits.hits,1) )
        snum = Vector{String}(undef,size(json_res.hits.hits,1) )
        firm_name = Vector{String}(undef,size(json_res.hits.hits,1) )
        firm_other_names =Vector{Vector{String}}(undef,size(json_res.hits.hits,1) )
        for i in 1 : size(json_res.hits.hits,1)
            crd[i]=json_res.hits.hits[i]._source.firm_source_id
            if haskey(json_res.hits.hits[i]._source,:firm_ia_full_sec_number)
                snum[i]=json_res.hits.hits[i]._source.firm_ia_full_sec_number
            elseif haskey(json_res.hits.hits[i]._source,:firm_bd_full_sec_number)
                snum[i]=json_res.hits.hits[i]._source.firm_bd_full_sec_number
            else
                snum[i] = ""
            end
        firm_name[i]=json_res.hits.hits[i]._source.firm_name
        firm_other_names[i]=convert(Array,json_res.hits.hits[i]._source.firm_other_names)
        end
    else
        snum, firm_name, firm_other_names, crd= [""],[""],[""],[""]
    end
    return (;name=firm_name, crd = crd, sec_num = snum,other_names = firm_other_names)
end

end