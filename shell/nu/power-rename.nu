def power-rename [
  from: string,
  to: any,
  --yes(-y)
] {
    let input = $in
    let result = ($input
        | get name
        | each { |it| 
            let parsed = ($it | parse $from)
            if ($parsed | is-empty) {
                null
            } else {
                {
                    in:$it, 
                    out:(do $to ($parsed | first))
                }
            }
        }
        | where {|it| $it != null })
        

    if ($result | is-empty) {
        print "Nothing to do"
        return
    }
    if not $yes {
        print "List of change :"
        print $result
        if (input "Do you want to apply this change ? (y/n) ") != "y" {
            return
        }
    }
    $result | each {
        mv $in.in $in.out
    } | ignore
}