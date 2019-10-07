$words = "*txt*", "*greek*", "*italian*", "*chinese(simplified)*", "*chinese(traditional)*", "*vietnamese*"

$files = Get-ChildItem -Recurse

foreach($file in $files) {
    foreach($word in $words) {
        if($file.Name -like $word) {
            Remove-Item $file.FullName
        }
    }
}