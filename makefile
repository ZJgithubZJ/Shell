SITES := site01 site02
.phony: all ${SITES}

all: ${SITES}

site01:
	@echo 'This is job1'
	@wget -p -r -N -l 2 -K -k http://www.site01.example.com; true
site02:
	@echo 'This is job2'
	@wget -p -r -N -l 2 -K -k http://www.site02.example.com; true
du:
	@for a in *; do du -sh $$a; done
