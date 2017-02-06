rule mkbed:
    input:"CTCF_NormalizedIntensity_G1E_G1EEr4.txt"
    output:"CTCF_NormalizedIntensity_G1E_G1EEr4_simple.bed"
    shell:"tail -n +2 {input} | cut -f 1,2,3 | sort -k1,1 -k2,2n > {output}"


rule mkepd_bed:
    input:"data/mouse_epdnew_W0EyU.bed"
    output:"mouse_epdnew_W0EyU_simple.bed"
    shell:"""tail -n +2 {input} | cut -f 1,2,4 | awk 'BEGIN{{FS=" "}} {{print $1 "\t" $2-50 "\t" $2+50 "\t" $3}}' | sort -k1,1 -k2,2n > {output}"""

rule intersector:
    input:ctcf="CTCF_NormalizedIntensity_G1E_G1EEr4_simple.bed",
          epd="mouse_epdnew_W0EyU_simple.bed"

    output:"CTCF_promoters.bed"
    shell:"bedtools intersect -wa -wb -a {input.ctcf} -b {input.epd} > {output}"