#!/bin/bash

#  files.sh
#  Date: 02 dic 2022
#  Author: Rubén Garrido 
#  Mail: rgarrido.rbn@gmail.com

if [ "$0" = "$BASH_SOURCE" ]; then
    echo "THIS SCRIPT MUST BE SOURCED!"
    exit 1
fi

CURR_DATE=$(date | awk '{print $2, $3, $4}')

create_c_file ()
{
cat > $1 <<EOF
/*
 *  $1
 *  
 *  Date: ${CURR_DATE}
 *  Author: Rubén Garrido 
 *  Mail: rgarrido.rbn@gmail.com
 *
 */
EOF
}

create_bash ()
{
cat > $1 <<EOF
#!/bin/bash

#  $1
#  Date: ${CURR_DATE}
#  Author: Rubén Garrido 
#  Mail: rgarrido.rbn@gmail.com
EOF
}

create_python ()
{
cat > $1 <<EOF
#!/bin/python

#  $1
#  Date: ${CURR_DATE}
#  Author: Rubén Garrido 
#  Mail: rgarrido.rbn@gmail.com
EOF
}

create_python3 ()
{
cat > $1 <<EOF
#!/bin/python3

#  $1
#  Date: ${CURR_DATE}
#  Author: Rubén Garrido 
#  Mail: rgarrido.rbn@gmail.com
EOF
}
