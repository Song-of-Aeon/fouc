// display_measure.cpp : Defines the exported functions for the DLL application.
//

//#include "stdafx.h"
#include <Windows.h>
#include <vector>
#define dllx extern "C" __declspec(dllexport)

std::vector<HMONITOR> display_capture_measure_vec;
BOOL CALLBACK display_capture_measure_all_proc(HMONITOR m, HDC hdc, LPRECT rect, LPARAM p) {
	display_capture_measure_vec.push_back(m);
	return TRUE;
}
dllx double display_measure_all_start_raw() {
	display_capture_measure_vec.clear();
	EnumDisplayMonitors(NULL, NULL, display_capture_measure_all_proc, 0);
	return display_capture_measure_vec.size();
}
//
struct dss_measure_ext {
	int mx, my, mw, mh;
	int wx, wy, ww, wh;
	int flags;
	char name[128];
};
dllx double display_measure_all_next_raw(double _i, dss_measure_ext* out) {
	int i = (int)_i;
	if (i < 0 || i >= display_capture_measure_vec.size()) return false;
	MONITORINFOEXA inf;
	inf.cbSize = sizeof inf;
	if (!GetMonitorInfoA(display_capture_measure_vec[i], &inf)) return false;
	//
	auto& rect = inf.rcMonitor;
	out->mx = rect.left;
	out->mw = rect.right - rect.left;
	out->my = rect.top;
	out->mh = rect.bottom - rect.top;
	//
	rect = inf.rcWork;
	out->wx = rect.left;
	out->ww = rect.right - rect.left;
	out->wy = rect.top;
	out->wh = rect.bottom - rect.top;
	//
	out->flags = inf.dwFlags;
	if (strncpy_s(out->name, inf.szDevice, sizeof inf.szDevice) != 0) {
		strncpy_s(out->name, "<unknown>", 32);
	}
	//
	return true;
}

dllx double display_measure_init_raw() { return 1; }
