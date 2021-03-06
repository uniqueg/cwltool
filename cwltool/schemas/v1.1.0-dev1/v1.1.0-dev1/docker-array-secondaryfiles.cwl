#!/usr/bin/env cwl-runner

cwlVersion: v1.1.0-dev1

requirements:
  - class: DockerRequirement
    dockerPull: debian:8
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement

class: CommandLineTool

inputs:
  fasta_path:
    type:
      type: array
      items: File
    secondaryFiles:
      - .fai

outputs:
  bai_list:
    type: File
    outputBinding:
      glob: "fai.list"

arguments:
  - valueFrom: ${
        var fai_list = "";
        for (var i = 0; i < inputs.fasta_path.length; i ++) {
          fai_list += " cat " + inputs.fasta_path[i].path +".fai" + " >> fai.list && "
        }
        return fai_list.slice(0,-3)
        }
    position: 1
    shellQuote: false

baseCommand: []
