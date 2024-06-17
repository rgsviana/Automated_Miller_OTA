per l perl_script_2_param_gen. pl
per l perl_script_3n_ckt_gen. pl
for i in 1. .10
do
ngspice nmos$i . c i r −batch −output=outN_$i . t x t
done
sed − i ’ s /
o14/fooo/g’ . / out * . t x t
sed − i " / foo/d" . / out * . t x t
sed − i " /n/d" . / out * . t x t
sed − i " /v/d" . / out * . t x t
sed − i " /−−/d" . / out * . t x t
sed − i " /N/d" . / out * . t x t