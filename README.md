# IAPDAdvisorInfo.jl

Retrieve firm names, CRD, and SEC numbers as well as other business names from www.adviserinfo.sec.gov

All functions return a `NamedTuple`

## Search by name strings:
```julia
julia> using IAPDAdvisorInfo
julia> using DataFrame

julia> get_iapd_by_name("JP Morgan") |> DataFrame
12×4 DataFrame
 Row │ name                               crd     sec_num     other_names
     │ String                             String  String      Array…
─────┼──────────────────────────────────────────────────────────────────────────────────────────
   1 │ JPMSI                              15733   8-32646     ["J.P. MORGAN MUNICIPAL FINANCE …
   2 │ J.P. MORGAN SECURITIES INC.        18718   8-36950     ["CHASE H&Q", "JPMORGAN H&Q", "J…
   3 │ JPMORGAN PARTNERS                  110373  801-58234   ["J.P. MORGAN PARTNERS, LLC", "J…
   4 │ JPMORGAN FUNDS LIMITED             172045  801-80071   ["J.P. MORGAN ASSET MANAGEMENT",…
  ⋮  │                 ⋮                    ⋮         ⋮                       ⋮
   9 │ J.P. MORGAN ADMINISTRADORA DE CA…  284147  802-107962  ["J.P. MORGAN ADMINISTRADORA DE …
  10 │ J.P. MORGAN ALTERNATIVE ASSET MA…  20989   801-38319   ["CHASE ALTERNATIVE ASSET MANAGE…
  11 │ J.P. MORGAN EQUITIES INC.          18350   8-36528     ["J.P. MORGAN EQUITIES INC."]
  12 │ J.P. MORGAN PRIME INC.             282107  8-69703     ["J.P. MORGAN PRIME INC."]
                                                                                  4 rows omitted

```

## Search by SEC-Number (801-XXXXX)
```julia
julia> get_iapd_by_number("801-69413")
(name = "WESTFIELD CAPITAL MANAGEMENT COMPANY, L.P.", crd = "146990", sec_num = "801-69413", other_names = ["WESTFIELD CAPITAL MANAGEMENT COMPANY, L.P."])
```