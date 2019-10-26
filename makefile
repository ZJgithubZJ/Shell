SITES := site01 site02
.phony: all ${SITES}

all: ${SITES}

site01:
	@echo 'This is job1'
	@wget -p -r -N -l 2 -K -k http://www.site01.example.com; true		#即使wget执行成功也会有返回不为零的情况，因此这里需要加一个true，make就会认为上一条指令执行返回的是0
site02:
	@echo 'This is job2'
	@wget -p -r -N -l 2 -K -k http://www.site02.example.com; true
du:
	@for a in *; do du -sh $$a; done	#‘$$a’为了跟shell的变量表示方法区分，使用两个'$$';且同一条指令不能占用多行，因此这些循环就在一行上编辑！
