
echo "create patch (${3}) from:"
echo "  -- a/${1}/*"
echo "  -- b/${2}/*"
echo

sed1="s/${1}\///"
sed2="s/${2}\///"

echo "and reformat to:"
echo "  -- a/* --> sed -i ${sed1} ${3}"
echo "  -- b/* --> sed -i ${sed2} ${3}"
echo

git diff --no-index "${1}" "${2}" > "${3}"
sed -i ${sed1} "${3}"
sed -i ${sed2} "${3}"
echo
echo "finished!"
