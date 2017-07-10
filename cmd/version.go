package cmd

import (
	"bytes"
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

const Name string = "ghc"
const Version string = "0.1.0"

var Revision string

// versionCmd represents the version command
var versionCmd = &cobra.Command{
	Use:   "version",
	Short: fmt.Sprintf("Print %s version and quit", Name),
	Long:  "No help topic for `version`",
	Run: func(cmd *cobra.Command, args []string) {
		var versionString bytes.Buffer

		fmt.Fprintf(&versionString, "%s %s", Name, Version)
		if Revision != "" {
			fmt.Fprintf(&versionString, " (%s)", Revision)
		}

		fmt.Fprintf(os.Stdout, "%s", versionString.String())
	},
}

func init() {
	RootCmd.AddCommand(versionCmd)
}
