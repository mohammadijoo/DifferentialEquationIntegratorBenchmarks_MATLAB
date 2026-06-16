function records = skipped_benchmark_record(benchRecord, methods, status)
records = empty_record_array();
for k = 1:numel(methods)
    rec = empty_record();
    rec.benchmark = benchRecord.name;
    rec.method = methods(k).name;
    rec.method_display = methods(k).displayName;
    rec.category = methods(k).category;
    rec.status = status;
    records(end+1,1) = rec; %#ok<AGROW>
end
end
