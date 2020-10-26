BEGIN {
    prevGCCount="FGC"
}
{
# Assuming the input has following format. So we try to retrieve the Full GC count from 11th field.
# ----------------------------------------------------------------------------------
# 2013/08/19 13:10:57 Timestamp         S0     S1     E      O      P     YGC     YGCT    FGC    FGCT     GCT
# 2013/08/19 13:10:57       2149625.8  30.33   0.00  43.92  45.45  59.98  29970  810.960    74    7.270  818.231
# ----------------------------------------------------------------------------------
    a[NR]=$0
    if ( $11 != prevGCCount ) {
        printf("%s\n%s\n",a[NR-1],a[NR])
        fflush()
        prevGCCount=$11
    }
}
END {
        fflush()
}
