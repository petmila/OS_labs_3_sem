
words=`awk -F ' ' '{print}' f1.sh`
for word in $words;
do
count=`grep -w "$word" f2.sh | wc -l`
if [[ $count > 0 ]]
then
echo "$word"
echo "$count"
fi
done