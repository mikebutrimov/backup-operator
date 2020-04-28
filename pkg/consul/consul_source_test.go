/*
Copyright 2020 Backup Operator Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package consul

import (
	"io/ioutil"
	"os"
	"path/filepath"

	"github.com/kubism/backup-operator/pkg/fs"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

var _ = Describe("ConsulSource", func() {
	It("should dump to file", func() {
		src, err := NewConsulSource(consulAddr, "", "", "test.snap")
		Expect(err).ToNot(HaveOccurred())
		Expect(src).ToNot(BeNil())
		dir, err := ioutil.TempDir("", "consulsrc")
		Expect(err).ToNot(HaveOccurred())
		defer os.RemoveAll(dir)
		fp := filepath.Join(dir, "test.snap")
		dst, err := fs.NewDirDestination(dir)
		Expect(err).ToNot(HaveOccurred())
		err = src.Stream(dst)
		Expect(err).ToNot(HaveOccurred())
		Expect(fp).Should(BeAnExistingFile())
		fi, err := os.Stat(fp)
		Expect(err).ToNot(HaveOccurred())
		Expect(fi.Size()).Should(BeNumerically(">", 0))
	})
})
