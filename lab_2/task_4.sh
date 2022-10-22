for pid in $(ps -axo pid | tail -n +2) #со второй строки
do
        # проверка на то, что в папках status и sched что-то лежит под этим pid
        if [[ -r /proc/$pid/status && -r /proc/$pid/sched ]] # -r - можем прочитать файл
        then
                # записываем данные в переменные через grep
                PPid=$(grep -s -E "^PPid" /proc/"$pid"/status | awk '{print $2}') #Берем $2 - значение Ppid
                sum_exec_runtime=$(grep -s -E "^se.sum_exec_runtime" /proc/$pid/sched | awk '{print $3}') 
                nr_switches=$(grep -s -E "^nr_switches" /proc/$pid/sched | awk '{print $3}')

                # если значение nr_switches не пустая строка
                # bc -l => калькулятор, точность 20 знаков после запятой
                if [[ ${nr_switches} -ne "" ]]
                then
                        avg_atom=$(echo "$sum_exec_runtime / $nr_switches" | bc -l | awk '{printf "%.2f", $0}') #в системе процессов определить среднее время непрерывного использования процессора (CPU_burst) и вывести в один файл
                fi
                echo "$pid $PPid $avg_atom"
        fi
done | sort -nk2 | awk '{print "ProcessID="$1" : Parent_ProcessID="$2" : Average_Running_Time="$3}' > 4.out
	