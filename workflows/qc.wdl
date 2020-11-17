version 1.0

workflow QC {

    input {
        Array[File]+ files
    }

    scatter(file in files) {
        call FastQC {
            input:
                file = file
        }
    }

    output {
        Array[File] reports = FastQC.report
        Array[File] reportZips = FastQC.reportZip
    }
}

task FastQC {

    input {
        File file
    }

    command {
        fastqc --outdir "." ${file}
    }

    runtime {
        docker: "welliton/fastqc:0.11.9"
    }

    output {
        File report = sub(basename(file), "\\..+", "_fastqc.html")
        File reportZip = sub(basename(file), "\\..+", "_fastqc.zip")
    }

}